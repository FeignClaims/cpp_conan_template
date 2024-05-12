#include "sample_lib/sort.hpp"

#include <range/v3/all.hpp>

namespace sample_lib {
void sort(std::vector<int>& vector) {
  ranges::sort(vector);
}
}  // namespace sample_lib