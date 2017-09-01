-- QN-04: Tags of questions which got answered within 1 hour

-- Sample Record: 1_563355_62701_0_1235000081_php,error,gd,image-processing_220_2_563372_67183_2_1235000501

src_dat_reln = load '/user/rajesh.kancharla_outlook/project3/source_data.txt' using PigStorage('_') as (seq_id:chararray, qn_id:chararray, qn_user_id:chararray, qn_score:chararray, qn_time:chararray, qn_tags:chararray, qn_views:chararray, qn_ans:chararray, ans_id:chararray, ans_user_id:chararray, ans_score:chararray, ans_time:long);

tags_data_qid_time = FOREACH src_dat_reln GENERATE qn_tags, qn_id as q, ToDate((long)ans_time*1000) as time;

tags_seperated_with_hour = FOREACH tags_data_qid_time GENERATE TOKENIZE(qn_tags), q as q, GetHour(time) as hour;

tags_flatten = FOREACH tags_seperated_with_hour GENERATE FLATTEN($0) AS tag, q as q, hour as hour;

tags_lessthanonehour = FILTER tags_flatten by hour <= 1;

tags_order = ORDER tags_lessthanonehour by tag;

STORE tags_order INTO '/user/rajesh.kancharla_outlook/project3/tags_ans_1hour';
