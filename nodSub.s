# nodSub.s
# Подпрограмма для нахождения НОД массива
.global nodSub
.text
nodSub:
  #Arguments
  
  #array_length -> a1
  #Addr(a[0])   -> a2
  
  li a5, 0
  addi a5, a1, -1 # a5 := array_length-1
  li a3, 0 # a3 = 0
    
  loop:
    beq a3, a5, loop_exit # if (a3 == a5) goto loop_exit1
  
    #t1:=addr(a[i]); 
    slli t1, a3, 2 # t1= a3 << 2 = a3 * 4
    add t1, a2, t1 # t1 = a2 + t1 = a2 + a3 * 4
  
    lw t2, 0(t1) #t2 := array[i]
      
    addi a3, a3, 1 #a3++
    
    slli t1, a3, 2 # t1= a3 << 2 = a3 * 4
    add t1, a2, t1 # t1 = a2 + t1 = a2 + a3 * 4
    
    lw t3, 0(t1) #t3 := array[i+1]
  
    loop_nod:
      beq t2, t3, loop_nod_exit # if (t2 == t3) got loop_nod_exit
      bgtu t2, t3, a_minus_b # if (t2 > t3) goto a_minus_b
      #(t2 <= t3)
      sub t4, t3, t2 # b = b - a
      mv t3, t4
      jal zero, loop_nod
      a_minus_b:
      #(t2 > t3)
      sub t4, t2, t3  #a = a - b
      mv t2, t4
      jal zero, loop_nod
    loop_nod_exit:
            
    sw t2, 0(t1) #array[i+1]:= t2
      
    addi a3, a3, -1 #a3--
      
    slli t1, a3, 2 # t1 = a3 << 2 = a3 * 4
    add t1, a2, t1 # t1 = a2 + t1 = a2 + a3 * 4
      
    sw t3, 0(t1) # array[i]:= t3
      
    addi a3, a3, 1 # a3++

    jal zero, loop  
  loop_exit:    
  # prints the result in t2
  li a0, 1
  mv a1, t2
  ecall

  ret # jalr zero, ra, 0