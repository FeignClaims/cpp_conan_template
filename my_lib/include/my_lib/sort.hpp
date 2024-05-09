#ifndef MY_LIB_SORT_HPP
#define MY_LIB_SORT_HPP

#include <vector>

namespace my_lib {
/**
 * Sort `std::vector` with the given comparison operator.
 * 
 * @param[out] vector The `std::vector` to be sorted.
 */
void sort(std::vector<int>& vector);
}  // namespace my_lib

#endif