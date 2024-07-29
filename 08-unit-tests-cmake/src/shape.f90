module shape_class

implicit none

  type :: shape
    character(10) :: name = "default"

    contains
      procedure :: area => area_shape
      procedure :: perimeter => perimeter_shape

  end type shape

  interface shape
    procedure construct_shape
  endinterface shape

  contains

  function construct_shape() result(a_shape)
    type(shape) :: a_shape
    
    a_shape%name = "no_shape"

  endfunction construct_shape

  function area_shape(this) result(a)
    implicit none
    class(shape),intent(in) :: this
    real :: a

      a = 0.0

  endfunction area_shape

  function perimeter_shape(this) result(p)
    implicit none
    class(shape),intent(in) :: this
    real :: p

      p = 0.0

  endfunction perimeter_shape
endmodule shape_class