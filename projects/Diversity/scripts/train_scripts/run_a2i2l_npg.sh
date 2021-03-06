#!/bin/sh

id="a2i2l_npg_"$1
ckpt_path="log_"$id

if [ ! -d $ckpt_path ]; then
  bash scripts/copy_model.sh a2i2l $id
fi

start_from="--start_from "$ckpt_path

python train.py --id $id --caption_model att2in2 --input_json data/cocotalk.json --input_label_h5 data/cocotalk_label.h5 --input_fc_dir data/cocobu_fc --input_att_dir data/cocobu_att --seq_per_img 5 --batch_size 50 --rnn_size 2048 --beam_size 1 --learning_rate 4.3e-5 --checkpoint_path $ckpt_path $start_from --save_checkpoint_every 3000 --language_eval 1 --val_images_use 5000 --max_epochs 100 --structure_after 28 --structure_sample_n 1 --structure_loss_weight $1 --structure_loss_type new_policy_gradient --eval_oracle 0 --sample_n 5 --sample_n_method sample 

#pid=$!
#echo $pid
#sleep 30
#kill -2 ${pid}
