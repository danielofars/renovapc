# RenovaPC

Kit gratuito e guiado para diagnosticar e limpar computadores Windows lentos, criado como projeto de inclusao digital: ajudar quem nao tem condicoes de trocar de computador a manter a maquina atual utilizavel por mais tempo.

Site do projeto: https://danielofars.github.io/renovapc/

## O problema social

Muitas familias, escolas publicas e ONGs continuam usando computadores considerados "obsoletos" simplesmente porque nao tem recursos para trocar de equipamento. Ao mesmo tempo, boa parte da lentidao desses computadores tem causas simples e resolviveis (arquivos temporarios acumulados, cache de atualizacao corrompido, configuracoes visuais pesadas) - nao falta de hardware. Faltam, isso sim, tempo, conhecimento tecnico acessivel e uma ferramenta que explique o que esta sendo feito e por que.

O RenovaPC nasceu do mesmo conhecimento tecnico usado no meu trabalho em suporte de TI (veja windows11-slow-pc-toolkit: https://github.com/danielofars/windows11-slow-pc-toolkit), mas reformulado para um publico leigo: linguagem simples, confirmacao antes de cada acao, e separacao clara entre passos seguros para qualquer pessoa e passos avancados que merecem apoio tecnico.

## Objetivos

O projeto tem quatro objetivos principais: ajudar pessoas sem conhecimento tecnico a resolver a lentidao do proprio computador com seguranca; reduzir o descarte precoce de computadores ainda funcionais (lixo eletronico); reduzir o custo de manutencao de informatica para familias, escolas e ONGs de baixa renda; e servir como material de apoio para voluntarios de projetos de inclusao digital.

## Quem e beneficiado

Familias de baixa renda com um unico computador em casa. Escolas publicas com laboratorios de informatica antigos. ONGs e telecentros que reformam e doam computadores usados. Pessoas idosas que preferem continuar usando o computador que ja conhecem.

## Tecnologias utilizadas

Batch script (Windows) para automacao das etapas de diagnostico e limpeza, sem depender de instalar nenhum programa extra. Ferramentas nativas do Windows: DISM, SFC, Limpeza de Disco, Otimizacao de Unidades e Storage Sense. HTML/CSS puro para o site estatico do projeto, hospedado gratuitamente via GitHub Pages, leve o suficiente para carregar em conexoes limitadas. Markdown para o guia de uso em linguagem simples.

## Impacto esperado

Cada computador que continua em uso por mais um ou dois anos representa uma economia real para quem ja tem pouco, e um equipamento a menos virando lixo eletronico. O objetivo nao e apenas tecnico: e dar a pessoas sem conhecimento de informatica a possibilidade de resolver um problema comum sozinhas, ou com apoio simples de um voluntario, sem depender de gastar dinheiro que nao tem.

## Estrutura do repositorio

RenovaPC.bat e o programa guiado, com menu em linguagem simples e confirmacao antes de cada acao. GUIA.md e o guia de uso para voluntarios e familias, sem termos tecnicos. index.html e o site estatico do projeto (GitHub Pages). LICENSE contem a licenca MIT.

## Como usar

Veja o passo a passo completo no GUIA.md. Resumo: baixe o RenovaPC.bat; clique com o botao direito e escolha Executar como administrador; siga o menu, que explica cada opcao antes de agir; e reinicie o computador ao final.

## Como contribuir

Sugestoes, correcoes e traducoes sao bem-vindas. Abra uma issue ou pull request neste repositorio. Se voce faz parte de uma ONG, escola ou telecentro e quer usar este material em oficinas, sinta-se a vontade - o projeto e gratuito e aberto (licenca MIT).

---
Autor: Daniel Oliveira
Area: Tecnologia da Informacao / Inclusao Digital
Inicio do projeto: Agosto de 2026
