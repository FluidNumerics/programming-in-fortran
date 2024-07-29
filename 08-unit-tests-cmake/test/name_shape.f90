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
  
  if(trim(obj%name) /= "no_shape")then
    print*,"error : incorrect obj%name : ",trim(obj%name)
    r = 1
    return
  endif
  print*, "obj%name : ", trim(obj%name)

  endfunction test_func

endprogram test