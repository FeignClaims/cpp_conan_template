#ifndef SAMPLE_LIB_SORT_HPP
#define SAMPLE_LIB_SORT_HPP

#include <vector>

namespace sample_lib {
/**
 * Sort `std::vector` with the given comparison operator.
 * 
 * @param[out] vector The `std::vector` to be sorted.
 */
void sort(std::vector<int>& vector);
}  // namespace sample_lib

#endif