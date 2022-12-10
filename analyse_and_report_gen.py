# Importing the necessary packages
import numpy as np                                  # "Scientific computing"
import pandas as pd                                 # Data Frame
import matplotlib.pyplot as plt                     # Basic visualisation
import seaborn as sns                               # Advanced data visualisation
import matplotlib.ticker as ticker
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)


def combined(df_daily):
    #  create plot for inside/outside combined
    plot2 = sns.lineplot(data=df_daily, x="timestamp", y="value",hue="value_type")
    plt.legend(title='Air quality type', loc='upper left', labels=['PM10', 'PM2.5'])
    plt.ylabel('Particulates in μm/m³')
    plt.xticks(rotation=15)
    fig = plot2.get_figure()
    fig.savefig('analysedata/combined.png') 
    plt.cla()
    plt.clf()
    # set the text for raport\u03bc
    file = "air quality" 
    titel = "Analysis of the particulates in the air"
    intro = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    left_image = "../analysedata/combined.png"
    right_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Congue quisque egestas diam in arcu cursus euismod quis. Id nibh tortor id aliquet lectus. Velit sed ullamcorper morbi tincidunt ornare massa eget. Molestie a iaculis at erat pellentesque adipiscing. Lectus arcu bibendum at varius vel pharetra vel. Vitae sapien pellentesque habitant morbi tristique senectus et netus et. Ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Commodo odio aenean sed adipiscing diam donec adipiscing tristique. Lorem sed risus ultricies tristique nulla. Elementum nibh tellus molestie nunc. </br> </br> Sem integer vitae justo eget magna fermentum iaculis eu non. Ornare aenean euismod elementum nisi quis eleifend quam adipiscing. Habitant morbi tristique senectus et netus et malesuada fames. Nisi est sit amet facilisis magna. Fermentum odio eu feugiat pretium nibh ipsum consequat nisl. Nisl vel pretium lectus quam id leo in. Venenatis urna cursus eget nunc scelerisque. Aliquam vestibulum morbi blandit cursus risus. Habitant morbi tristique senectus et netus. Turpis egestas integer eget aliquet nibh praesent tristique magna sit. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula ullamcorper. Bibendum neque egestas congue quisque egestas. Porta lorem mollis aliquam ut porttitor leo. Nisl condimentum id venenatis a. Amet venenatis urna cursus eget nunc. Est sit amet facilisis magna etiam tempor orci eu. Porta lorem mollis aliquam ut porttitor leo a. Mauris in aliquam sem fringilla. Neque viverra justo nec ultrices dui sapien eget."
    
    simple_template(file,titel,intro,left_image,right_text)

def separate(df_daily_complex):
    # create plot for inside/outside
    plot = sns.lineplot(data=df_daily_complex, x="timestamp", y="value",hue="is_indoor",style="value_type")
    plt.legend(title='Air quality', loc='upper left', labels=['PM10  outside', 'PM2.5 outside','PM10  inside','PM2.5 inside'])
    plt.ylabel('Particulates in μm/m³')
    plt.xticks(rotation=15)
    fig = plot.get_figure()
    fig.savefig('analysedata/separated.png')  
    plt.cla()
    plt.clf()
    
    # set the text for raport
    file = "air quality difference"
    titel = "Analysis of the particulates in the air split between inside and outside"
    intro = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    left_image = "../analysedata/combined.png"
    right_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Congue quisque egestas diam in arcu cursus euismod quis. Id nibh tortor id aliquet lectus. Velit sed ullamcorper morbi tincidunt ornare massa eget. Molestie a iaculis at erat pellentesque adipiscing. Lectus arcu bibendum at varius vel pharetra vel. Vitae sapien pellentesque habitant morbi tristique senectus et netus et. Ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Commodo odio aenean sed adipiscing diam donec adipiscing tristique. Lorem sed risus ultricies tristique nulla. Elementum nibh tellus molestie nunc. </br> </br> Sem integer vitae justo eget magna fermentum iaculis eu non. Ornare aenean euismod elementum nisi quis eleifend quam adipiscing. Habitant morbi tristique senectus et netus et malesuada fames. Nisi est sit amet facilisis magna. Fermentum odio eu feugiat pretium nibh ipsum consequat nisl. Nisl vel pretium lectus quam id leo in. Venenatis urna cursus eget nunc scelerisque. Aliquam vestibulum morbi blandit cursus risus. Habitant morbi tristique senectus et netus. Turpis egestas integer eget aliquet nibh praesent tristique magna sit. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula ullamcorper. Bibendum neque egestas congue quisque egestas. Porta lorem mollis aliquam ut porttitor leo. Nisl condimentum id venenatis a. Amet venenatis urna cursus eget nunc. Est sit amet facilisis magna etiam tempor orci eu. Porta lorem mollis aliquam ut porttitor leo a. Mauris in aliquam sem fringilla. Neque viverra justo nec ultrices dui sapien eget."
    
    simple_template(file,titel,intro,left_image,right_text)
        
def simple_template(file,titel,intro,left_image,right_text):
    with  open(f"generatedreports/{file}.md", "w") as md:
        md.write(f'# {titel}\n')
        md.write(f'"PM10 and PM2.5 reference the size of particulates measured in micro meters. In European countries there is no level of particulates which is considered safe.\n\n [Source](https://en.wikipedia.org/wiki/Particulates)"\n')
        md.write(f'{intro}\n')
        md.write(f' <img src="{left_image}" alt="left graph" style="width:100%"> \n')
        md.write(f'{right_text} ')
        

# Generate difrent reports
if __name__ == "__main__":
    # get clean data file
    df  = pd.read_csv('C:\\Users\\kevin\\Documents\\school\\2022-2023\\semester 1\\3 Linux for Data Scientists\\Proof-of-concept geautomatiseerde data workflow\\cleandata\\cleandata.csv')
    
    # change the format of data to a more usefull format for graphs
    df['timestamp'] = pd.to_datetime(df['timestamp']).dt.normalize().astype('datetime64[ns]')
    
    # pass the data int he correct from to the different templates
    combined(df[['value_type','value','timestamp']].groupby('value_type').resample('D', on='timestamp').mean())
    separate(df[['value_type','value','timestamp','is_indoor']].groupby(['value_type','is_indoor']).resample('D', on='timestamp').mean())