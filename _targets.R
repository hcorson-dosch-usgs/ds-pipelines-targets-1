library(targets)
source('1_fetch/src/sb_utils.R')
source('2_process/src/munge_model_data.R')
source('3_visualize/src/plot_model_results.R')
tar_option_set(packages = c("tidyverse", "stringr", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    sb_download(sb_id = '5d925066e4b0c4f70d0d0599', 
                file_name = 'me_RMSE.csv', 
                out_file = '1_fetch/out/model_RMSEs.csv'),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    munge_rmses(in_file = model_RMSEs_csv),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    plot_rmses(data = eval_data,
               out_file = '3_visualize/out/figure_1.png'), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    {
      out_file = "2_process/out/model_summary_results.csv"
      write_csv(eval_data, 
                file = out_file)
      return(out_file)
    }, 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    render_model_diagnostics(data = eval_data, out_file = '2_process/out/model_diagnostic_text.txt'), 
    format = "file"
  )
)