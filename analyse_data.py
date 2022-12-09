# Importing the necessary packages
import numpy as np                                  # "Scientific computing"

import pandas as pd                                 # Data Frame

import matplotlib.pyplot as plt                     # Basic visualisation
import seaborn as sns                               # Advanced data visualisation

import matplotlib.ticker as ticker

import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

def main():
    # get clean data file
    df  = pd.read_csv('C:\\Users\\kevin\\Documents\\school\\2022-2023\\semester 1\\3 Linux for Data Scientists\\Proof-of-concept geautomatiseerde data workflow\\cleandata\\cleandata.csv')

    # change the format of data to a more usefull format for graphs
    df['timestamp'] = pd.to_datetime(df['timestamp']).dt.normalize().astype('datetime64[ns]')

    df_daily = df[['value_type','value','timestamp']].groupby('value_type').resample('D', on='timestamp').mean()
    df_daily_complex = df[['value_type','value','timestamp','is_indoor']].groupby(['value_type','is_indoor']).resample('D', on='timestamp').mean()

    # create plot for inside/outside
    plot = sns.lineplot(data=df_daily_complex, x="timestamp", y="value",hue="is_indoor",style="value_type")
    plt.legend(title='Air quality', loc='upper left', labels=['PM10  outside', 'PM2.5 outside','PM10  inside','PM2.5 inside'])
    plt.ylabel('Particulates in μm/m³')
    plt.xticks(rotation=30)
    fig = plot.get_figure()
    fig.savefig('analysedata/separated.png')  
    plt.cla()
    plt.clf()
    
    #  create plot for inside/outside combined
    plot2 = sns.lineplot(data=df_daily, x="timestamp", y="value",hue="value_type")
    plt.legend(title='Air quality type', loc='upper left', labels=['PM10', 'PM2.5'])
    plt.ylabel('Particulates in μm/m³')
    plt.xticks(rotation=30)
    fig = plot2.get_figure()
    fig.savefig('analysedata/combined.png') 
    plt.cla()
    plt.clf()


if __name__ == "__main__":
    main()
    