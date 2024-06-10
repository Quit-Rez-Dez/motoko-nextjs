#dApp (Motoko)

REGISTROS 

## Run in the cloud

Usamos codespace para correr el proyecto

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Quit-Rez-Dez/motoko-nextjs/?quickstart=1)

## Run Codespace

Abrimos terminal y poner 

Start a ICP local replica:

```bash
dfx start --background --clean
```

Get your canister ids:


Generate did files:

```bash
dfx generate test
```

Deploy your canisters:

```bash
dfx deploy
```

You will receive a result similar to the following (ids could be different four you):

```bash
URLs:
 
  Backend canister via Candid interface:
    backend: http://127.0.0.1:4943/?canisterId=bd3sg-teaaa-aaaaa-qaaba-cai&id=bkyz2-fmaaa-aaaaa-qaaaq-cai
```

Abrimos pestaña de puertos en  visual y buscamos el puerto 
4943

copiamos el link que nos muestra y lo remplazamos en la respuesta que nos da al mandar el dfx deploy

         ||||||||||||||||||||||    Esto es lo que se remplaza por la url que nos da la pestaña ports de visual
         vvvvvvvvvvvvvvvvvvvvvv 
backend: http://127.0.0.1:4943/ ?canisterId=bd3sg-teaaa-aaaaa-qaaba-cai&id=bkyz2-fmaaa-aaaaa-qaaaq-cai

Ejemplo
https://organic-spoon-gp7j6w46g9h96jx-4943.app.github.dev/?canisterId=bd3sg-teaaa-aaaaa-qaaba-cai&id=bkyz2-fmaaa-aaaaa-qaaaq-cai

Cuando abra el candidUI

mandamos en createRegistro

##usuario    String

##movimiento String


Para consultar usamos GetallValues
  
