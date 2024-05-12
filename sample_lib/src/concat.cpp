#include "sample_lib/concat.hpp"

#include <range/v3/all.hpp>

namespace sample_lib {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string {
  return lhs + rhs;
}
}  // namespace sample_lib