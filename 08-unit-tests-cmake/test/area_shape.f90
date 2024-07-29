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
  real :: a

  obj = shape()
  r = 0
  a = obj%area()
  if(a /= 0.0)then
    print*,"error: incorrect area : ",a
    r = 1
    return
  endif
  print*,"obj%area() : ",a

  endfunction test_func

endprogram test