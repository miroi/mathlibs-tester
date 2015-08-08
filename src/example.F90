program example
#if defined (VAR_INTEL)
   USE IFPORT
#endif
   implicit none
   integer, parameter :: nfixed = 8
   integer :: n, i, j, info, verb, nargs
   real(8), allocatable :: a(:, :),as(:,:)
   real(8), allocatable :: b(:,:),bs(:,:)
   integer, allocatable :: ipiv(:)
   real(8), external :: dnrm2
#if defined (VAR_PGI)
   real(8), external :: rand
#endif
   real(8) :: zeronorm, aij, bij
   character*5 :: arg1, arg2
   real(4) ::  t1,t2

!Read input from the command line 

   nargs = IARGC() 
   if (nargs == 0) n = nfixed 
   if (nargs /= 0 .and. nargs /= 1 .and. nargs /= 2) then
     print *,"usage: bin/example"
     print *,"       bin/example  matrix_size"
     print *,"       bin/example  matrix_size  verbosity"
     stop "wrong command line arguments !"
   endif

   verb = 0 ! default verbosity level

   if (nargs == 1) then 
     call getarg(1,arg1)
     read(arg1,*) n
     !print *,'n=',n
   endif
   if (nargs == 2) then
     call getarg(1,arg1); call getarg(2,arg2)
     read(arg1,*) n
     read(arg2,*) verb
     !print *,'n=',n
     !print *,'verb=',verb
   endif

   allocate(a(n,n),as(n,n))
   allocate(b(n,n),bs(n,n))
   allocate(ipiv(n))

   ! fill A,b with numbers
   do i=1,n
   do j=1,n
#if defined OWN_FILLED
    ! use formulas
    aij=log( (dfloat(i)+dfloat(j)-0.24) / (dfloat(i)-0.045))
    !bij=log( (dfloat(i)+dfloat(j)+0.3637 / (dfloat(i)*dfloat(j)-0.27389))) -
!dfloat(i)
    bij=aij-((dfloat(i)+dfloat(j))/(2*dfloat(i)-dfloat(j)+0.336))
#else
    ! use random numbers
    aij=rand();bij=rand()
#endif
    a(i,j)=aij;b(i,j)=bij
    as(i,j)=a(i,j);bs(i,j)=b(i,j)
   enddo
   enddo

   call CPU_TIME( t1 )

   call dgesv( n, n, a, n, ipiv, b, n , info )
   if (info.gt.0) stop "error in dgesv routine !"

   if (verb >= 4) then
     print *,'A:',as
     print *,'b:',bs
   endif
   if (verb >= 3) then
     print *,'roots Ax=b, x:',b
   endif
! get Ax-b into bs
   call dgemm('n', 'n', n, n, n, 1.0D0, as, n, b, n, -1.0D0, bs, n)
   !print *,'zero matrix, Ax-b=0',bs

   ! the bs should be zero matrix, check it
   ! get euklid.norm |A.x-b| - must be zero
     zeronorm=dnrm2(n*n,bs,1)/(dfloat(n)*dfloat(n))
   call CPU_TIME( t2 )
   if (verb >= 2) then
     print *,'zero matrix norm',zeronorm
   endif

   if (zeronorm.le.1.0d-10) then
     print *,'dgesv-dgemm-dnrm2 lapack/blas test ok'
     if (verb >= 1) then
       write (*,"('Time = ',f7.3,' seconds.')"),t2-t1
     endif
   else
     stop 'dgesv-dgemm-dnrm2 lapack/blas test failed!'
   endif

end program
