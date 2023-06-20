# wA
Desafio para consumir API do github em Swift

## Pré-requisito para rodar o app na sua máquina
    Swift 5, xCode 14.3, CocoaPods, Brew, GitHub

## Passo a passo para executar o projeto
 - Abra o prompt de comando, siga para pasta que deseja baixar o projeto
 - Clone o projeto pelo github:
    - ```git clone https://github.com/AbrantesMar/wA.git```
 - Acesse a pasta do projeto:
    - ```cd carr```
 - Execute o seguinte comando na pasta:
    - ```pod install``` 
     - O pod irá instalar as libs que utilizei
        - RxSwift 6.5.0, Alamofire 5.7.1, 
 - Abra o workspace no xCode com o seguinte comando
    - ```open carr.xcworkspace```

## Alguns comandos já estão no arquivo Makefile para otimizar os processos. 
##### No prompt dentro da pasta carr, existe alguns comandos preparados para ajudar a atualizar, iniciar e refazer o pod install.(todos os comandos têm que estar com o xcode aberto para executá-los). 
- make init 
- make update
- make clean

