# - Customization point for project_options: https://github.com/aminya/project_options
# This module customizes and runs `dynamic_project_options(...)`.
#
# Note that this module should be included after `project(...)`.
include_guard()

if(NOT _sample_project_project_options_POPULATED)
  message(FATAL_ERROR "please `include(sample_project_fetch_project_options)`")
endif()

# compile_commands.json
set(ENABLE_COMPILE_COMMANDS_SYMLINK_DEFAULT ON)

# hardening
set(ENABLE_CONTROL_FLOW_PROTECTION_DEFAULT ON)
set(ENABLE_ELF_PROTECTION_DEFAULT OFF)
set(ENABLE_OVERFLOW_PROTECTION_DEFAULT ON)
set(ENABLE_RUNTIME_SYMBOLS_RESOLUTION_DEFAULT ON)

if(WIN32 AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  set(ENABLE_STACK_PROTECTION_DEFAULT OFF)
else()
  set(ENABLE_STACK_PROTECTION_DEFAULT ON)
endif()

# optimization
if (NOT (LINUX AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")) # Disable linux gcc until https://gitlab.kitware.com/cmake/cmake/-/issues/23136
  set(ENABLE_INTERPROCEDURAL_OPTIMIZATION_DEFAULT ON)
endif()
set(ENABLE_NATIVE_OPTIMIZATION_DEFAULT ON)

dynamic_project_options(
  PREFIX
  "sample_project" # set a prefix in case this project is used as a subproject

  MSVC_WARNINGS
  /W4 # Baseline reasonable warnings
  /permissive- # standards conformance mode for MSVC compiler
  /w14242 # 'identifier': conversion from 'type1' to 'type1', possible loss of data
  /w14254 # 'operator': conversion from 'type1:field_bits' to 'type2:field_bits', possible loss of data
  /w14263 # 'function': member function does not override any base class virtual member function
  /w14265 # 'classname': class has virtual functions, but destructor is not virtual instances of this class may not be destructed correctly
  /w14287 # 'operator': unsigned/negative constant mismatch
  /w14296 # 'operator': expression is always 'boolean_value'
  /w14311 # 'variable': pointer truncation from 'type1' to 'type2'
  /w14545 # expression before comma evaluates to a function which is missing an argument list
  /w14546 # function call before comma missing argument list
  /w14547 # 'operator': operator before comma has no effect; expected operator with side-effect
  /w14549 # 'operator': operator before comma has no effect; did you intend 'operator'?
  /w14555 # expression has no effect; expected expression with side- effect
  /w14619 # pragma warning: there is no warning number 'number'
  /w14640 # Enable warning on thread un-safe static member initialization
  /w14826 # Conversion from 'type1' to 'type_2' is sign-extended. This may cause unexpected runtime behavior
  /w14905 # wide string literal cast to 'LPSTR'
  /w14906 # string literal cast to 'LPWSTR'
  /w14928 # illegal copy-initialization; more than one user-defined conversion has been implicitly applied
  /we4289 # nonstandard extension used: 'variable': loop control variable declared in the for-loop is used outside the for-loop scope

  CLANG_WARNINGS
  -Wall
  -Wextra # reasonable and standard
  -Wcast-align # warn for potential performance problem casts
  -Wcast-function-type # warn about function typemismatches in casts
  -Wconversion # warn on type conversions that may lose data
  -Wcovered-switch-default # warn if use default labels in fully covered switches over enumerations. This helps when a new enum value is added
  -Wdouble-promotion # warn if float is implicit promoted to double
  -Wextra-semi # warn about semicolon after in-class function definition
  -Wfloat-equal # warn on comparing floating point with == or !=
  -Wformat=2 # warn on security issues around functions that format output (ie printf)
  # -Wglobal-constructors  # warn on declare global or static variables with dynamic constructors
  -Wimplicit-fallthrough # warn on statements that fallthrough without an explicit annotation
  -Wmisleading-indentation # warn if indentation implies blocks where blocks do not exist
  -Wmissing-noreturn # warn about functions that might be candidates for [[noreturn]]
  -Wno-braced-scalar-init # todo: remove this when it is correct
  -Wnon-virtual-dtor # warn the user if a class with virtual functions has a non-virtual destructor. This helps catch hard to track down memory errors
  -Wnull-dereference # warn if a null dereference is detected
  -Wold-style-cast # warn for c-style casts
  -Woverloaded-virtual # warn if you overload (not override) a virtual function
  -Wpacked # warn if a structure is given the packed attribute, but the packed attribute has no effect on the layout or size of the structure
  -Wpedantic # warn if non-standard C++ is used
  -Wpointer-arith # warn on pointer arithmetic
  -Wshadow # warn the user if a variable declaration shadows one from a parent context
  -Wsign-conversion # warn on sign conversions
  -Wtautological-compare # warn for tautological comparisons
  -Wthread-safety # warn for thread safety
  -Wundef # warn if an undefined identifier is evaluated in an #if directive
  -Wunreachable-code-aggressive # warn if code will never be executed
  -Wunused # warn on anything being unused
  -Wno-gnu-line-marker # avoid the warn on gnu line marker when `--save-temps=obj` enabled
  -Wno-unused-command-line-argument # disable warn if command line argument unused
  -ftemplate-backtrace-limit=0
  -fconstexpr-backtrace-limit=0

  GCC_WARNINGS
  -Wall
  -Wextra # reasonable and standard
  -Wcast-align # warn for potential performance problem casts
  -Wconversion # warn on type conversions that may lose data
  -Wdisabled-optimization # warn if a requested optimization pass is disabled. often, the problem is that your code is too big or too complex
  -Wdouble-promotion # warn if float is implicit promoted to double
  -Wduplicated-branches # warn if if / else branches have duplicated code
  -Wduplicated-cond # warn if if / else chain has duplicated conditions
  -Wextra-semi # warn about semicolon after in-class function definition
  -Wfloat-equal # warn on comparing floating point with == or !=
  -Wformat=2 # warn on security issues around functions that format output (ie printf)
  -Wimplicit-fallthrough # warn on statements that fallthrough without an explicit annotation
  -Winvalid-pch # warn if a precompiled header is found in the search path but cannot be used
  -Wlogical-op # warn about logical operations being used where bitwise were probably wanted
  -Wmisleading-indentation # warn if indentation implies blocks where blocks do not exist
  -Wmissing-format-attribute # Warn about function pointers that might be candidates for format attributes
  -Wmissing-include-dirs # warn if a user-supplied include directory does not exist
  -Wmissing-noreturn # warn about functions that might be candidates for [[noreturn]]
  -Wnon-virtual-dtor # warn the user if a class with virtual functions has a non-virtual destructor. This helps catch hard to track down memory errors
  -Wnull-dereference # warn if a null dereference is detected
  -Wold-style-cast # warn for c-style casts
  -Woverloaded-virtual # warn if you overload (not override) a virtual function
  -Wpedantic # warn if non-standard C++ is used
  -Wpointer-arith # warn on pointer arithmetic
  -Wredundant-decls # warn if anything is declared more than once in the same scope, even in cases where multiple declaration is valid and changes nothing
  -Wshadow # warn the user if a variable declaration shadows one from a parent context
  -Wsign-conversion # warn on sign conversions
  -Wundef # warn if an undefined identifier is evaluated in an #if directive
  -Wunused # warn on anything being unused
  -Wuseless-cast # warn if you perform a cast to the same type
  -Wno-unused-command-line-argument # disable warn if command line argument unused

  CPPCHECK_OPTIONS
  --enable=style,performance,warning,portability
  --inline-suppr
  --suppress=cppcheckError # We cannot act on a bug/missing feature of cppcheck
  --suppress=internalAstError
  --suppress=unmatchedSuppression # if a file does not have an internalAstError, we get an unmatchedSuppression error
  --suppress=passedByValue
  --suppress=syntaxError
  --inconclusive
)
