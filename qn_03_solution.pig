-- QN-03: Number of questions which got answered within 1 hour

-- Sample Record: 1_563355_62701_0_1235000081_php,error,gd,image-processing_220_2_563372_67183_2_1235000501

src_dat_reln = load '/user/rajesh.kancharla_outlook/project3/source_data.txt' using PigStorage('_') as (seq_id:chararray, qn_id:chararray, qn_user_id:chararray, qn_score:chararray, qn_time:chararray, qn_tags:chararray, qn_views:chararray, qn_ans:chararray, ans_id:chararray, ans_user_id:chararray, ans_score:chararray, ans_time:long);

qn_id_avg_time_reln = FOREACH src_dat_reln GENERATE qn_id as qn_id, ToDate((long)ans_time*1000) as ans_time;

qn_id_gethour_reln = FOREACH qn_id_avg_time_reln GENERATE qn_id as qn_id, ans_time as ans_time, GetHour(ans_time) as ans_hour;

qn_id_hour_less_1_reln = FILTER qn_id_gethour_reln by ans_hour <= 1;

STORE qn_id_hour_less_1_reln INTO '/user/rajesh.kancharla_outlook/project3/qn_ans_1hour';