# Countdown_FPGA (Trabalho T2)

![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen)
![Language](https://img.shields.io/badge/Language-VHDL-blue)
![Platform](https://img.shields.io/badge/Platform-FPGA%20Nexys-orange)

**Disciplina:** Projeto e Prototipação de Circuitos Digitais - UFSC

## Descrição
Implementação em VHDL de um cronômetro decrescente com precisão de 1 segundo. Este projeto serve como base e módulo preliminar para o desenvolvimento de sistemas de temporização mais complexos (T3).

## Plataforma e Hardware
* Placa: Digilent Nexys 1 ou Nexys 2.
* Clock Principal: 50 MHz.
* Periféricos de Saída: 4 displays de 7 segmentos e LEDs.
* Periféricos de Entrada: 8 chaves deslizantes e botões push-button nativos.

## Funcionalidades e Estados
O controle do circuito é regido por uma máquina de estados finitos (FSM) contendo três estados principais:
* IDLE: Estado de repouso (aguardando operação).
* LOAD: Carrega o valor inicial dos minutos (de 01 a 99) inserido nas chaves deslizantes. Os segundos iniciam em 00.
* COUNT: Realiza a contagem decrescente até atingir 00:00, retornando automaticamente para IDLE e acendendo o LED indicador de parado.

## Controles
* reset: Zera os mostradores (00:00) e apaga o LED parado.
* carga: Aciona o estado LOAD para ler o valor das chaves.
* conta: Inicia a contagem decrescente.
