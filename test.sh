# Script para testes de unidade automaticos

# Configuracao: escolhe se o programa retonara mensagens teste-a-teste
verbose=$2

# A primeira linha indica que o script foi inicializado corretamente
if [ $verbose -eq 1 ]; then
  echo "Testando $1"
fi;

# A variavl dirtestes indica onde os arquivos teste (.in e .out) estao
dirbelem=./xml/belem
dircorumba=./xml/corumba
dirjoao=./xml/joao_monlevade
dirlima=./xml/nova_lima
dirparauapebas=./xml/parauapebas
dirrio=./xml/rio_de_janeiro
dirsaoluis=./xml/sao_luis

program=$1

# Expressao do SED que significa: substituir .in por .out
sedexpression='s/\.xml/\.csv/'

# tests sera inicializada com o resultado da expressao find,
# encontrando todos os arquivos .xml do diretorio dirtestes
belem=`find $dirbelem -name '*.xml'`
corumba=`find $dircorumba -name '*.xml'`
joao=`find $dirjoao -name '*.xml'`
lima=`find $dirlima -name '*.xml'`
parauapebas=`find $dirparauapebas -name '*.xml'`
rio=`find $dirrio -name '*.xml'`
saoluis=`find $dirsaoluis -name '*.xml'`

# Para cada teste...
for t in $belem
do
  out=`echo $t | sed $sedexpression`
  # Executa o programa que foi compilado usando o arquivo xml como entrada
  $program < $t > $out
done

for t in $corumba
do
  out=`echo $t | sed $sedexpression`
  # Executa o programa que foi compilado usando o arquivo xml como entrada
  $program < $t > $out
done

for t in $joao
do
  out=`echo $t | sed $sedexpression`
  # Executa o programa que foi compilado usando o arquivo xml como entrada
  $program < $t > $out
done

for t in $lima
do
  out=`echo $t | sed $sedexpression`
  # Executa o programa que foi compilado usando o arquivo xml como entrada
  $program < $t > $out
done

for t in $parauapebas
do
  out=`echo $t | sed $sedexpression`
  # Executa o programa que foi compilado usando o arquivo xml como entrada
  $program < $t > $out
done

for t in $rio
do
  out=`echo $t | sed $sedexpression`
  # Executa o programa que foi compilado usando o arquivo xml como entrada
  $program < $t > $out
done

for t in $saoluis
do
  out=`echo $t | sed $sedexpression`
  # Executa o programa que foi compilado usando o arquivo xml como entrada
  $program < $t > $out
done
