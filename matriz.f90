
MODULE FUNCOES

	CONTAINS

	!retorna o numero de bits
	function nbits(numerador) result (n)

		implicit none

		integer :: numerador
		integer :: n
		integer :: resto
		integer :: numero

		n = 1

		numero  = numerador

		do while(int(numero/2) /=0)

			numero = int(numero / 2.0)

			n = n + 1

		end do

	end function

end module

program matriz
	USE FUNCOES

	implicit none
	integer :: i,j,c,nb,valor,z,w
	integer :: linhas,colunas,posicao
	integer :: sinal
	integer :: constante,aux
	integer, allocatable :: vetor(:,:)

	real :: tempo_inicio
	real :: tempo_final

	open (file ='tempo_execucao_matrizCompacta.dat',unit=10, status='unknown', form='formatted')
	open (file ='tempo_execucao_matrizNormal.dat',unit=20, status='unknown', form='formatted')

	linhas = 20
	colunas = 20

	valor = 10

	nb = nbits(valor)

	write(*,*) 'nb...',nb

	constante = 0

	call mvbits(1,0,1,constante,63)

	!write(*,'(B64.64)') constante

	!pause

	do linhas = 10,100000,1000

		do colunas = 10,100000,1000

			write(*,*) linhas,colunas

			c = int(colunas*nb/64)+1
			!write(*,*) 'c...',c

			allocate(vetor(linhas,c))

			vetor = 0

			call cpu_time(tempo_inicio)

			do i = 1, linhas

				z = 0

				do j = 1, colunas

					!constante = mod((j-1)*nb,64)

				!	if( constante < nb)then

				!		z = 0

				!	else

				!		z = z + nb

				!	end if

					sinal = mod((j-1)*nb,64) - nb
					!write(*,'(B64.64)') sinal
					sinal = ishftc(iand(sinal,constante),1,64)

					!write(*,'(B64.64)') sinal
					!pause
					z = (z + nb)*(1-sinal)

					!write(*,*) 'j...',j
					!write(*,'(B64.64)') valor
					!write(*,*) 'posicao...',mod((j-1)*nb,64)

					!write(*,'(B64.64)') ISHFTC (valor,mod((j-1)*nb,64),64)
					!write(*,'(B64.64)') vetor(i,int((j-1)*nb/64)+1)

					!write(*,*) '#############################'
					!vetor(i,int((j-1)*nb/64)+1) = IOR(vetor(i,int((j-1)*nb/64)+1),ISHFTC (valor,mod((j-1)*nb,64),64))
					
					aux = int((j-1)*nb/64)+1
					vetor(i,aux) = IOR(vetor(i,aux),ISHFTC (valor,z,64))

				end do

			end do

			call cpu_time(tempo_final)

			write(10,'(i20,i20,f20.5,i20)') linhas,colunas,tempo_final-tempo_inicio,SIZEOF(vetor)

		!	do i = 1, linhas
		!		do j = 1, c

		!			write(*,'(B64.64)') vetor(i,j)

		!		end do
		!	end do

			!pause

			deallocate(vetor)

			allocate(vetor(linhas,colunas))

			call cpu_time(tempo_inicio)

			vetor = 0

			do i = 1, linhas
				do j = 1, colunas
					vetor(i,j) = valor
				end do
			end do

			call cpu_time(tempo_final)

			write(20,'(i20,i20,f20.5,i20)') linhas,colunas,tempo_final-tempo_inicio,SIZEOF(vetor)

			deallocate(vetor)

		end do

	end do

end program matriz

