#!/bin/bash

set -e # 每个脚本都应该在文件开头加上set -e,这句语句告诉bash如果任何语句的执行结果不是true则应该退出。
# 这样的好处是防止错误像滚雪球般变大导致一个致命的错误

# #
# # Setup
# #

echo "--- SETUP ---"

# Example:
# Model type: CNNRNNTextEncoder
# Checkpoint path: outputs/shapenet_cnn_rnn/2017-06-15_00-20-32/model.ckpt-5000
# Log path: outputs/shapenet_cnn_rnn/2017-06-15_00-20-32
ckpt_path=$2
log_path=$(dirname $ckpt_path)

echo "Model type:" $1  # Model type (e.g. ConditionalThreeDWGAN
echo "Checkpoint path: $ckpt_path"
echo "Log path: $log_path"

# #
# # Run test script
# #

echo "--- TEST SCRIPT ---"

# for split in "train" "val" "test"; do  # All splits
# for split in "test"; do  # Test split only
for split in "train"; do # Test train only
    cur_log_path="$log_path/$split"
    echo "Current log path: $cur_log_path"
    python main.py --model $1 \
        --text_encoder \
        --test \
        --save_outputs \
        --lba_test_mode text \
        --log_path $cur_log_path \
        --ckpt_path $ckpt_path \
        --val_split $split \
        $3
done
echo ""
