import pandas as pd
import numpy as np
import datetime
import time 
from sklearn import preprocessing
import matplotlib.pyplot as plt

from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import AdaBoostClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.datasets import make_gaussian_quantiles
from sklearn.cross_validation import cross_val_score
from sklearn.cross_validation import cross_val_score


log_train_s = pd.read_csv('/home/jason/downloard/KDD/log_train_s_c2.csv')
objec=pd.read_csv('/home/jason/downloard/KDD/log_train_s_c2.csv')
train = log_train_s
del train['Unnamed: 0']
del train['id']
train_data = train.values
train_data_scaled = preprocessing.scale(train_data)

true_train = pd.read_csv('/home/jason/downloard/KDD/truth_train.csv')
target_data = [0]
for val in true_train.values:
	target_data.append(val[1])

log_test_s = pd.read_csv('/home/jason/downloard/KDD/log_test_s_c2.csv')
ID = log_test_s['id']
test = log_test_s
del test['Unnamed: 0']
del test['id']
test_data = test.values
test_data_scaled = preprocessing.scale(test_data)

#bdt = RandomForestClassifier(n_estimators=200)
#bdt = AdaBoostClassifier(DecisionTreeClassifier(max_depth=2),algorithm="SAMME",n_estimators=180)
bdt = GradientBoostingClassifier(n_estimators=180, learning_rate=1,max_depth=1,random_state=0)
#bdt=RandomForestClassifier(n_estimators=180,max_depth=3,min_samples_split=2, random_state=0)
#bdt = AdaBoostClassifier(n_estimators=100);

X = train_data_scaled
y = np.array(target_data)


bdt.fit(X,y)
result = bdt.predict_proba(test_data_scaled)
ID_num = ID.values

print bdt.feature_importances_
scores = cross_val_score(bdt, X,y)
print scores.mean()
print bdt.feature_importances_
re1= []
re2= []
re = []
j = 0
for i in range(len(ID_num)):
	re.append(int(ID_num[i]))
	re.append(result[i][1])
	
re_narray= np.array(re)
output = re_narray.reshape(len(result),2)
np.savetxt('/home/jason/downloard/KDD/result/GradientBoostingClassifier.txt',output,fmt=["%d","%f"],delimiter=",")

#output_0 = pd.read_csv('/home/jason/downloard/KDD/result/DecisionTree_SAMME_10_200_p.txt')
