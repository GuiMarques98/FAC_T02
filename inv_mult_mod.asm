        .data
msg1:   .asciiz "Digite um numero primo responsavel pelo modulo: "
msg2:   .asciiz "Digite o numero do inverso multiplicativo: "
n_prime: .asciiz "O modulo nao eh primo."
inv_mult: .asciiz "O inverso multiplicativo e: "
        .text

#Parte principal do codigo
main:
        la $a0, msg1    #carrega o endereco da msg1 em $a0
        jal r_integer  #chama a funcao r_interger
        move $s0, $v0   #carrega o numero inteiro lido em $s0

        la $a0, msg2    #carrega o endereco da msg2 em $a0
        jal r_integer  #chama a funcao r_interger
        move $s1, $v0   #carrega o numero inteiro lido em $s1


        move $a0, $s0   #carrega a chamada
        jal is_prime    #chama a função 
        
	move $t1, $v0  #salva o valor da condição	
	
	beq $v0, $zero, print_out_prime #se não for primo mostra na tela
	#calculo do inverso 
	
	j calc_inv
	
	return_inv:
	
	return_prime:

        li $v0, 10      #carrega variavel para terminar a execucao do programa
        syscall         #finaliza o programa
end_main:


#Le numero inteiro
#$a0: a mensagem mandada para o usuario
r_integer:
        li $v0, 4       #carrega instrucao para printar na tela
        syscall         #Chamada de sistema para printar a msg q vem como parametro

        li $v0, 5       #carrega instucao para ler um numero inteiro
        syscall         #le um numero inteiro
        jr $ra          #retorna o numero lido
end_r_integer:


#Verifica se e um numero primo
#$a0: possivel numero primo
is_prime:
        beqz $a0, not_prime     #verifica se $a0 eh zero se sim o numero nao eh primo
        beq $a0, 2, prime       #verifica se o numero em $a0 eh 2 se for eh primo
        beq $a0, 1, prime       #verifica se o numero em $a0 eh 1 se for eh primo
        and $t0, $a0, 0x00000001#faz o and entre $a0 e 1, pra verificar se o numero eh par
        beqz $t0, not_prime     #caso o numero for par o numero nao eh primo
        li $t0, 3       #carrega o contador $t0 com numero 3

while_is_prime:
        bge $t0, $a0, prime     #caso o numero for maior ou igual ao contador $t0 o numero eh primo

        div $a0, $t0    #divide o numero passado para o contador $t0
        mfhi $t1        #carrega o mod da divisao da linha cima

if_is_prime:
        beqz $t1, not_prime     #verifica se $t1 eh igual a zero, se for o numero nao eh primo
end_if_is_prime:

        addi $t0, $t0, 2        #adiciona 2 ao numero $t0 e guarta o resultado em $t0
        j while_is_prime        #pula para o while_is_prime
end_while_is_prime:


prime:
        move $v0, $a0   #Carrega o numero $a0 ao valor de retorno $v0
        jr $ra          #sai da funcao

not_prime:
        move $v0, $zero #Carrega o numero 0 ao valor de retorno $v0
        jr $ra          #sai da funcao

end_is_prime:


#calcula o inverso multiplicativo modular
calc_inv:
	xor $t0, $t0, $t0 #zerando o contador 

	while_calc:
		addi $t0, $t0, 1 #incrementa o contador
		mult $s0,$t0 #multiplica  A*C
		mflo $t1  #pegando o resultado da multiplicação
 		div $t1, $s1 # A*C /  B
 		mfhi $t1 # pegando o resto de da divião  

		
		
	bne $t1, 1, while_calc
	j print_out_inv
end_calc_inv:


#Imprime erros
#$a0 : o endereco onde tem a mensagem printada
print_error:

end_print_error:


#Imprime saida
#$a0 : numero inverso multiplicativo calculado
print_out_prime:

	la $a0, n_prime
	li $a1, 1
	li $v0, 55
	syscall
j return_prime
end_print_out_prime:	
#imprime o inverto multiplicativo no registrador $v0
print_out_inv:

	la $a0, inv_mult #mostra a string
	move $a1, $t0 #movimenta o primo para $a1 
	li $v0, 56
	syscall 
	j return_inv
	
end_print_out_inv:
