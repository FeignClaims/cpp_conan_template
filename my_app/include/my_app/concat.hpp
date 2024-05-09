#ifndef MY_APP_CONCAT_HPP
#define MY_APP_CONCAT_HPP

#include <string>

namespace my_app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string;
}  // namespace my_app

#endif