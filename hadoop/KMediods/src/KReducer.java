import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;


public class KReducer extends Reducer<Text, Text, Text, Text> {
	
	
	public void reduce(Text key,Iterable<Text> value,Context context) throws IOException,InterruptedException
	{
		String outVal = "";
		int count=0;
		String center="";
		int length = key.toString().replace("(", "").replace(")", "").replace(":", "").split(",").length;
		float[] ave = new float[Float.SIZE*length];
		float[] new_xy= new float[Float.SIZE*length];
		for(int i=0;i<length;i++)
		{
			ave[i]=0;
			new_xy[i]=0;
		} 
		float min_val = 99999;
		for(Text val:value)
		{
			float min_tmp=0;
			outVal += val.toString()+" ";
			String[] tmp = val.toString().replace("(", "").replace(")", "").split(",");
			for(Text val1:value)
			{
				String[] tmp2 = val1.toString().replace("(", "").replace(")", "").split(",");
				for(int j = 0;j < length; j++)
				{
					ave[j] += Math.pow(Float.parseFloat(tmp2[j])-Float.parseFloat(tmp[j]),2);
					min_tmp += ave[j];
				}
			}
				
			if(min_tmp < min_val)
			{
				min_val = min_tmp;
				for(int j =0;j<length;j++)
				{
					new_xy[j]=Float.parseFloat(tmp[j]);
				}
			}	
		}
		for(int i=0;i<length;i++)
		{
			if(i==0)
				center += "("+new_xy[i]+",";
			else {
				if(i==length-1)
					center += new_xy[i]+")";
				else {
					center += new_xy[i]+",";
				}
			}
		}
		System.out.println("input:"+key+" "+outVal+" "+center);
		context.write(key, new Text(outVal+center));
	}

}
