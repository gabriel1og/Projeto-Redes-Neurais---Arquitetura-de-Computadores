                .data

erro:           .word 0
peso1:          .float 0.8
peso2:          .float 0.0
taxa_aprende:	.float 0.022
zero:	        .float 0.0
incremento:	.float 1.0

                .text

main:	        lwc1 $f0, peso1 	# registrador com valor do primeiro peso
	        lwc1 $f1, peso2 	#registrador com valor do segundo peso
                lwc1 $f2, taxa_aprende 	# registrador da taxa de aprendizagem
	        lwc1 $f3, zero 	# registrador da "entrada" do treinamento
                addi $t0, $zero, 1	# registrador do indice do for
	        lwc1 $f11, incremento
          
for:            slti $t6, $t0, 5
                beq $t6, $zero, fim

                mul.s $f4, $f0, $f3 	# peso1*entrada
                mul.s $f5, $f1, $f3 	# peso2*entrada
                add.s $f6, $f3, $f3 	# calculo saida esperada
	        add.s $f7, $f4, $f5 	# calculo saida do neuronio

                sub.s $f8, $f6, $f7 # calculo do erro = saida esperada - saida do neuronio
	        swc1 $f8, erro
	        # peso = peso + (erro*saida esperada*taxa de aprendizagem)
	        mul.s $f9, $f8, $f2
	        mul.s $f10, $f9, $f6
	        add.s $f0, $f10, $f0
	        add.s $f1, $f10, $f1

                swc1 $f0, peso1 # redefinição do valor do peso 1
                swc1 $f1, peso2 # redefinição do valor do peso 2

   	 
	        add.s $f3, $f3, $f11 # incremento da entrada
	        addi $t0, $t0, 1 # incremento do indice


                j for 

fim:            jr $r
