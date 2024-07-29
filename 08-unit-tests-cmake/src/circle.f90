module circle_class
use shape_class

implicit none

  type, extends(shape) :: circle
    real :: radius

  contains
    procedure :: area => area_circle
    procedure :: perimeter => perimeter_circle

  end type circle

  interface circle
    procedure construct_circle
  endinterface circle

  real, private :: pi = 4.0*atan(1.0)
  contains

  function construct_circle(r) result(a_circle)
    type(circle) :: a_circle
    real, intent(in) :: r
    
    a_circle%name = "circle"
    a_circle%radius = r

  endfunction construct_circle

  function area_circle(this) result(a)
    implicit none
    class(circle),intent(in) :: this
    real :: a

      a = pi*this%radius*this%radius

  endfunction area_circle

  function perimeter_circle(this) result(p)
    implicit none
    class(circle),intent(in) :: this
    real :: p

      p = 2.0*pi*this%radius

  endfunction perimeter_circle

end module circle_class