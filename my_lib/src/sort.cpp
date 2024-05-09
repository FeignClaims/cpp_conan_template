#include "my_lib/sort.hpp"

#include <range/v3/all.hpp>

namespace my_lib {
void sort(std::vector<int>& vector) {
  ranges::sort(vector);
}
}  // namespace my_lib