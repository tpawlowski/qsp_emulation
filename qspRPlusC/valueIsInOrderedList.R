#####################################################################################################
# Returns true if 'value' is in 'orderedList', false otherwise.
# Assumes that 'orderedList' is indeed ordered.
#####################################################################################################
valueIsInOrderedList = function(value, orderedList) {
  
  listLength <- length(orderedList);

  #####################################################################################################
  # Nested function to recursively do binary search for 'value' in 'orderedList'.
  # Assumes that 'orderedList' is indeed ordered and that the values in it corresponding to 
  # 'currentMinIndex' and 'currentMaxIndex' have already been checked and found to not be equal to
  # 'value'.
  #####################################################################################################
  valueIsInOrderedListRecursive = function(value, currentMinIndex, currentMaxIndex) {
    
    # A precondition of this nested function is that the min and max values have already been checked
    # and are not equal to the required value so if this condition is true we know the required value
    # is not in the list, note that the second part of the condition is necessary because the
    # way we update the min/max indices does not guarantee they will eventually become equal
    if (currentMinIndex == currentMaxIndex || currentMinIndex + 1 == currentMaxIndex) {
      return(FALSE);
    }
    
    midIndex = as.integer(pmax(1, pmin(listLength, ceiling((currentMinIndex + currentMaxIndex) / 2))));
    
    if (value == orderedList[midIndex]) {
      return(TRUE);
    } else if (value < orderedList[midIndex]) {
      return(valueIsInOrderedListRecursive(value, currentMinIndex, midIndex));
    } else {
      return(valueIsInOrderedListRecursive(value, midIndex, currentMaxIndex));
    }
  }
  
  
  # Use the nested function, if required, to find out if the value is in the list
  
  # If list is empty then the value cannot be in it
  if (0 == listLength) {
    return(FALSE);
  }
  
  # Is important that we do these checks here because the nested function assumes that, each time
  # it is called, the values corresponding to the min and max indices will have already been
  # checked and found to be not equal to the required value
  if (value == orderedList[1] || value == orderedList[listLength]) {
    return(TRUE);
  }
  
  return(valueIsInOrderedListRecursive(value, 1, listLength));
}

