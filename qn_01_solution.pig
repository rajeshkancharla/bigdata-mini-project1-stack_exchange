-- QN-01: Top 10 most commonly used tags in this data set.

-- Sample Record: 1_563355_62701_0_1235000081_php,error,gd,image-processing_220_2_563372_67183_2_1235000501

src_dat_reln = load '/user/rajesh.kancharla_outlook/project3/source_data.txt' using PigStorage('_') as (seq_id:chararray, qn_id:chararray, qn_user_id:chararray, qn_score:chararray, qn_time:chararray, qn_tags:chararray, qn_views:chararray, qn_ans:chararray, ans_id:chararray, ans_user_id:chararray, ans_score:chararray, ans_time:chararray);

tags_data_reln = FOREACH src_dat_reln GENERATE qn_tags;

tags_reln = FOREACH tags_data_reln GENERATE FLATTEN(TOKENIZE($0)) as tag;

tags_grp_reln = GROUP tags_reln BY tag;

tags_cnt_reln = FOREACH tags_grp_reln GENERATE group, COUNT(tags_reln) AS cnt;

tags_sorted_reln = ORDER tags_cnt_reln BY cnt DESC;

tags_top_10_reln = LIMIT tags_sorted_reln 10;

STORE tags_top_10_reln INTO '/user/rajesh.kancharla_outlook/project3/top_10_tags';
