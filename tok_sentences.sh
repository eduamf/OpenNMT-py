# faz a tokenização de todos
for l in en pt; do for f in data/txtCelex/*.$l; do perl tools/tokenizer.perl -a -no-escape -l $l -q  < $f > $f.atok; done; done

# copia quem vai ser treino
cat src-2016.pt.atok > train.pt.atok
cat trg-2016.en.atok > train.en.atok

# copia as 1000 primeiras linhas de quem vai ser validação
cat src-2017.pt.atok | sed -n '1,1000p' > val.pt.atok
cat trg-2017.en.atok | sed -n '1,1000p' > val.en.atok

# copia as próximas 1000 primeiras linhas de quem vai ser teste
cat src-2017.pt.atok | sed -n '1001,2000p' > test.pt.atok
cat trg-2017.en.atok | sed -n '1001,1000p' > test.en.atok

# preprocess.py -- tamanho do arquivo de treinamento
python preprocess.py -train_src data/txtCelex/train.pt.atok -train_tgt data/txtCelex/train.en.atok -valid_src data/txtCelex/val.pt.atok -valid_tgt data/txtCelex/val.en.atok -save_data data/txtCelex.atok.low -lower

# train.py
python train.py -data data/txtCelex.atok.low -save_model txtCelex_model

######
for l in en de; do for f in data/multi30k/*.$l; do if [[ "$f" != *"test"* ]]; then sed -i "$ d" $f; fi;  done; done
for l in en de; do for f in data/multi30k/*.$l; do perl tools/tokenizer.perl -a -no-escape -l $l -q  < $f > $f.atok; done; done
python preprocess.py -train_src data/multi30k/train.en.atok -train_tgt data/multi30k/train.de.atok -valid_src data/multi30k/val.en.atok -valid_tgt data/multi30k/val.de.atok -save_data data/multi30k/multi30k.atok.low -lower

unrecognized arguments: -gpu_ranks 0 no treinamento train.py por conta de diferenças corrigidas no github

python train.py -data data/multi30k.atok.low -save_model multi30k_model -gpuid 0






