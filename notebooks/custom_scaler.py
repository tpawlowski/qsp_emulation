import pickle
from pathlib import Path

from sklearn.preprocessing import MinMaxScaler
import numpy as np

LOGNORMAL_PARAMETERS = (1, 2)


class CustomScaler:
    def __init__(self):
        super().__init__()
        self.scaler = MinMaxScaler()
        self.plot_loval = [0.0] * len(LOGNORMAL_PARAMETERS)
        self.plot_hival = [1.0] * len(LOGNORMAL_PARAMETERS)

    def transform(self, x: np.ndarray, copy=None) -> np.ndarray:
        res = self.scaler.transform(x)
        for i, parameter_index in enumerate(LOGNORMAL_PARAMETERS):
            res[:, parameter_index] = (x[:, parameter_index] - self.plot_loval[i]) / (
                    self.plot_hival[i] - self.plot_loval[i]
            )

        return res

    def fit(self, x, copy=None):
        self.scaler.fit(x)
        for i, parameter_index in enumerate(LOGNORMAL_PARAMETERS):
            column_values = x[:, parameter_index]

            quantile_1, quantile_3 = np.quantile(column_values, [0.25, 0.75], axis=0)
            iqr = quantile_3 - quantile_1

            loval = quantile_1 - 1.5 * iqr
            hival = quantile_3 + 1.5 * iqr

            wiskhi = np.compress(column_values <= hival, column_values)
            wisklo = np.compress(column_values >= loval, column_values)
            actual_hival = np.max(wiskhi)
            actual_loval = np.min(wisklo)

            self.plot_loval[i] = actual_loval
            self.plot_hival[i] = actual_hival

        return self

    def inverse_transform(self, x, copy=None):
        res = self.scaler.inverse_transform(x)
        for i, parameter_index in enumerate(LOGNORMAL_PARAMETERS):
            res[:, parameter_index] = (
                    x[:, parameter_index] * (self.plot_hival[i] - self.plot_loval[i])
                    + self.plot_loval[i]
            )
        return res


_SCALAR = {}


def get_scaler(data_dir_path: Path, data_train: np.ndarray) -> CustomScaler:
    """
    Get scaler from file or create new one. The function cache the scaler in memory.

    :param data_dir_path: path to directory where scaler will be saved
    :param data_train: array with train data to initialize scaler
    :return: scaler itself
    """
    data_dir_path_ = data_dir_path.resolve()

    if data_dir_path_ not in _SCALAR:
        scaler_path = data_dir_path_ / "scaler.pickle"

        if scaler_path.exists():
            with scaler_path.open("rb") as scaler_file:
                _SCALAR[data_dir_path_] = pickle.load(scaler_file)
        else:
            _SCALAR[data_dir_path_] = CustomScaler().fit(data_train)
            with scaler_path.open("wb") as opened_file:
                pickle.dump(_SCALAR[data_dir_path_], opened_file)
    return _SCALAR[data_dir_path_]
