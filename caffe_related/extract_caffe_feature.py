
#usage cd caffe
#usage python ctrip.py $your_file_list
import numpy as np
import matplotlib.pyplot as plt
#read file_list
import sys
import string
f = open(sys.argv[1], "r")   
filenames=[]
labels=[]
vgg_labels=[]#for vgg_output storage
while True:   

    line = f.readline()   

    if line:   

        pass    # do something here  

        line=line.strip() 
        line_temp = line.split(' ')
        file_path = line_temp[0]
        label = line_temp[1]
        label = string.atoi(label)
        #print "create %s"%line 
        #print label
        filenames.append(file_path)
        labels.append(label)
    else:   

        break



# Make sure that caffe is on the python path:
caffe_root = '/home/luxi/caffe-master_taurus/'  # this file is expected to be in {caffe_root}
import sys
sys.path.insert(0, caffe_root + 'python')

import caffe

import os

#caffe.set_mode_cpu()
caffe.set_device(0)
caffe.set_mode_gpu()
#net = caffe.Net(caffe_root + 'vgg_finetune/train_val_for_feature_extraction.prototxt',
#               caffe_root + 'vgg_finetune/dec04_iter_11000.caffemodel',
#               caffe.TRAIN)

net = caffe.Net(caffe_root + 'models/bvlc_reference_caffenet/deploy.prototxt',
                caffe_root + 'models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel',
                caffe.TRAIN)				
				
				
# input preprocessing: 'data' is the name of the input blob == net.inputs[0]
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
transformer.set_transpose('data', (2,0,1))
transformer.set_mean('data', np.load(caffe_root +'python/caffe/imagenet/ilsvrc_2012_mean.npy').mean(1).mean(1)) # mean pixel
transformer.set_raw_scale('data', 255)  # the reference model operates on images in [0,255] range instead of [0,1]
transformer.set_channel_swap('data', (2,1,0))  # the reference model has channels in BGR order instead of RGB
#####################################################################################################################
net.blobs['data'].reshape(1,3,227,227)
cnt = 0
for single_filename in filenames:
    print single_filename
    net.blobs['data'].data[...] = transformer.preprocess('data', caffe.io.load_image(single_filename))
    out = net.forward()
    feat = net.blobs['fc7'].data[0];
    f_size = feat.size;
    f_tmp = feat.reshape(f_size,1);
    if cnt == 0:
	feature_all = f_tmp
    else:
	feature_all = np.append(feature_all,f_tmp)
		
#print("Predicted class is #{}.".format(out['fc8_new'][0].argmax()))
    cnt = cnt + 1
	
sio.savemat('cnn_feature1.mat',{'feature_all':feature_all})

#import pdb
#pdb.set_trace()
#predict_temp = np.array(vgg_labels) - np.array(labels)
#count_num = np.count_nonzero(predict_temp)
#accuracy_rate = (len(predict_temp)-count_num) / len(predict_temp)
#print accruacy_rate
######################################################################################################################
