library(sbtools)
library(dplyr)
library(readr)
library(stringr)
library(whisker)

source('1_fetch/src/sb_utils.R')
source('2_process/src/munge_model_data.R')
source('3_visualize/src/plot_model_results.R')

sb_download(sb_id = '5d925066e4b0c4f70d0d0599', file_name = 'me_RMSE.csv', out_file = '1_fetch/out/model_RMSEs.csv')

munge_rmses(in_file = '1_fetch/out/model_RMSEs.csv', out_file = '2_process/out/model_summary_results.csv')

render_model_diagnostics(in_file = '2_process/out/model_summary_results.csv', out_file = '2_process/out/model_diagnostic_text.txt')

plot_rmses(in_file = '2_process/out/model_summary_results.csv', out_file = '3_visualize/out/figure_1.png')