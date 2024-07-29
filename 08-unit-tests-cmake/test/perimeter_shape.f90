program test

  implicit none
  integer :: exit_code

  exit_code = test_func()
  stop exit_code

contains

  integer function test_func() result(r)
  use shape_class
  implicit none
  type(shape) :: obj
  real :: p

  obj = shape()
  r = 0

  p = obj%perimeter()
  if(p /= 0.0)then
    print*,"error: incorrect perimeter : ",p
    r = 1
    return
  endif
  print*,"obj%perimeter() : ",p

  endfunction test_func

endprogram test