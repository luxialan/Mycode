import pandas as pd
import numpy as np
import datetime
import time 
from pandas import Series,DataFrame

path = '/home/jason/downloard/KDD/log_train.csv';

log_train = pd.read_csv(path);
enrollment_train= pd.read_csv('/home/jason/downloard/KDD/enrollment_train.csv')
log_test = pd.read_csv('/home/jason/downloard/KDD/log_test.csv')
true_train = pd.read_csv('/home/jason/downloard/KDD/truth_train.csv')
object = pd.read_csv('/home/jason/downloard/KDD/object.csv')
date_new = pd.read_csv('/home/jason/downloard/KDD/date.csv')
#log_train_s1 = pd.read_csv('/home/jason/downloard/KDD/log_train_s_new.csv')

a = log_train;
a['source']=a['source'].replace({'server':0,'browser':1})
a['event']=a['event'].replace({'problem':0,'video':1,'access':2,'wiki':3,'discussion':4,'nagivate':5,'page_close':6})

start_time = time.clock()
total_usr = len(a['enrollment_id'].drop_duplicates())
id_total = a['enrollment_id'].drop_duplicates()
log_train_s = pd.DataFrame(np.random.randn(total_usr,13),columns=['id','id_c','time_c','time','s0','s1','e0','e1','e2','e3','e4','e5','e6'])
total_course=object.course_id.drop_duplicates()
course_all = total_course.values
course_all=Series(list(course_all))

for usr in range(0,total_usr):
	print('usr=',usr)
	event={}
	source={}
	tmp_a= a[a.enrollment_id == id_total.values[usr]]
	usr_len = len(tmp_a)
	for i in range(0,7):
		event[i] = len(tmp_a[tmp_a.event == i])
	for i in range(0,2):
		source[i] = len(tmp_a[tmp_a.source==i])
	usr_t = 0;
	i=0
	t_tol = len(tmp_a['time'])
	data= tmp_a['time']
	while (i < t_tol):
		index_t=data.index[i]
		t_str=data[index_t];
		y1 = t_str[0:4]
		m1 = t_str[5:7]
		d1 = t_str[8:10]
		h1 = t_str[11:13]
		mi1= t_str[14:16]
		s1 = t_str[17:20]
		date1 =datetime.datetime(int(y1),int(m1),int(d1),int(h1),int(mi1),int(s1))
		for j in range(i,t_tol):
			t_str = data[data.index[j]]
			y2 = t_str[0:4]
			m2 = t_str[5:7]
			d2 = t_str[8:10]
			h2 = t_str[11:13]
			mi2= t_str[14:16]
			s2 = t_str[17:20]
			date2 =datetime.datetime(int(y2),int(m2),int(d2),int(h2),int(mi2),int(s2))
			if (date1.year !=date2.year) or(date1.month!=date2.month)or(date1.day!=date2.day):
				usr_t+=(date2 - date1).days
				break
		i = j+1
		print('i=',i)
		print('calone:',time.clock()-start_time )
	course_id = enrollment_train[enrollment_train.enrollment_id == id_total.values[usr]].course_id.values[0]
	index_a=date_new[date_new.course_id.values == course_id]['from'].values[0]
	index_b=date_new[date_new.course_id.values == course_id]['to'].values[0]
	course_num=course_all[course_all==course_id].index[0]
	course_t = 0
	
	t_str=index_a
	y1 = t_str[0:4]
	m1 = t_str[5:7]
	d1 = t_str[8:10]
	date1 =datetime.datetime(int(y1),int(m1),int(d1))
	t_str = index_b
	y2 = t_str[0:4]
	m2 = t_str[5:7]
	d2 = t_str[8:10]
	date2 =datetime.datetime(int(y2),int(m2),int(d2))
	course_t=(date2 - date1).days
	#object[object.course_id == course_id].module_id.drop_duplicates()
	log_train_s['id'][usr] = id_total.values[usr]
	log_train_s['id_c'][usr] = course_num
	log_train_s['time_c'][usr] = course_t
	log_train_s['time'][usr] = usr_t
	log_train_s['s0'][usr] = source[0]
	log_train_s['s1'][usr] = source[1]
	log_train_s['e0'][usr] = event[0]
	log_train_s['e1'][usr] = event[1]
	log_train_s['e2'][usr] = event[2]
	log_train_s['e3'][usr] = event[3]
	log_train_s['e4'][usr] = event[4]
	log_train_s['e5'][usr] = event[5]
	log_train_s['e6'][usr] = event[6]
log_train_s.to_csv('/home/jason/downloard/KDD/log_train_s_c2.csv')
