        .data
msg1:   .asciiz "Digite um numero primo responsavel pelo modulo: "
msg2:   .asciiz "Digite o numero do inverso multiplicativo: "
n_prime: .asciiz "O modulo nao eh primo."
inv_mult: .asciiz "O inverso multiplicativo eh"
        .text

#Parte principal do codigo
main:
        la $a0, msg1    #carrega o endereco da msg1 em $a0
        jal r_interger  #chama a funcao r_interger
        move $s0, $v0   #carrega o numero inteiro lido em $s0

        la $a0, msg2    #carrega o endereco da msg2 em $a0
        jal r_interger  #chama a funcao r_interger
        move $s1, $a0   #carrega o numero inteiro lido em $s1

        move $a0, $s0   #
        jal is_prime    #

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
is_prime:

end_is_prime:


#calcula o inverso multiplicativo modular
calc_inv:

end_calc_inv:


#Imprime erros
#$a0 : o endereco onde tem a mensagem printada
print_error:

end_print_error:


#Imprime saida
#$a0 : numero inverso multiplicativo calculado
print_out:

end_print_out:
