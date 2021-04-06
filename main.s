# main.s
.global __start

#Определим данные:
.rodata
array_length:
    .word 8
#Секция изменяемых данных:  
.data
array: #массив
  .word 9,18,30,60,120,36,33,24
    
.text
__start:

  addi sp, sp, -16	# выделение памяти в стеке
  sw ra, 12(sp)		# сохранение ra

  lw a1, array_length # \
  la a2, array        #  } nodSub(array_length, array); 
  call nodSub         # /  
  
  lw ra, 12(sp)		# восстановление ra
  addi sp, sp, 16	# освобождение памяти в стеке

  li a1, 0
  li a0, 17
  ecall 