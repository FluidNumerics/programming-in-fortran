module square_class
    use shape_class
    
    implicit none
    
      type, extends(shape) :: square
        real :: side_length
    
      contains
        procedure :: area => area_square
        procedure :: perimeter => perimeter_square
    
      end type square
    
      interface square
        procedure construct_square
      endinterface square
    
      contains
    
      function construct_square(l) result(a_square)
        type(square) :: a_square
        real, intent(in) :: l
        
        a_square%name = "square"
        a_square%side_length = l
    
      endfunction construct_square
    
      function area_square(this) result(a)
        implicit none
        class(square),intent(in) :: this
        real :: a
    
          a = this%side_length*this%side_length
    
      endfunction area_square
    
      function perimeter_square(this) result(p)
        implicit none
        class(square),intent(in) :: this
        real :: p
    
          p = 4.0*this%side_length
    
      endfunction perimeter_square
    
    end module square_class