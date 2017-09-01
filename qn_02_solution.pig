-- QN-02: Average time to answer questions

-- Sample Record: 1_563355_62701_0_1235000081_php,error,gd,image-processing_220_2_563372_67183_2_1235000501

src_dat_reln = load '/user/rajesh.kancharla_outlook/project3/source_data.txt' using PigStorage('_') as (seq_id:chararray, qn_id:chararray, qn_user_id:chararray, qn_score:chararray, qn_time:chararray, qn_tags:chararray, qn_views:chararray, qn_ans:chararray, ans_id:chararray, ans_user_id:chararray, ans_score:chararray, ans_time:long);

qn_id_reln = GROUP src_dat_reln BY qn_id;

avg_time_reln = FOREACH qn_id_reln GENERATE group, src_dat_reln.qn_id AS qn_id, AVG(src_dat_reln.ans_time) AS avg_time;

avg_ans_time_reln = FOREACH avg_time_reln GENERATE qn_id, ToDate((long)avg_time*1000) as avg_ans_time;

STORE avg_ans_time_reln INTO '/user/rajesh.kancharla_outlook/project3/avg_ans_time';