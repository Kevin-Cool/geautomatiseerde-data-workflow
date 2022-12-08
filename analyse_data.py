# Importing the necessary packages
import numpy as np                                  # "Scientific computing"

import pandas as pd                                 # Data Frame

import matplotlib.pyplot as plt                     # Basic visualisation
import seaborn as sns                               # Advanced data visualisation

import matplotlib.ticker as ticker

def main():
    # get clean data file
    df  = pd.read_csv('C:\\Users\\kevin\\Documents\\school\\2022-2023\\semester 1\\3 Linux for Data Scientists\\Proof-of-concept geautomatiseerde data workflow\\cleandata\\cleandata.csv')

    # change the format of data to a more usefull format for graphs
    df['timestamp'] = pd.to_datetime(df['timestamp']).dt.normalize().astype('datetime64[ns]')

    df_daily = df[['value','timestamp','is_indoor']].resample('D', on='timestamp').mean()
    df_daily_indoor = df.query("is_indoor == 1")[['value','timestamp','is_indoor']].resample('D', on='timestamp').mean()
    df_daily_outdoor = df.query("is_indoor == 0")[['value','timestamp','is_indoor']].resample('D', on='timestamp').mean()
    df_daily_complex = pd.concat([df_daily_indoor, df_daily_outdoor], axis=0)
    df_daily_complex = df_daily_complex.reset_index()

    # create plot for inside/outside
    plot = sns.lineplot(data=df_daily_complex, x="timestamp", y="value",hue="is_indoor")
    plt.legend(title='Air quality', loc='upper left', labels=['outside', 'inside'])
    plt.ylabel('Air quality')
    plt.xticks(rotation=30)
    fig = plot.get_figure()
    fig.savefig('saperate.png')  
    plt.cla()
    plt.clf()
    
    #  create plot for inside/outside combined
    plot2 = sns.lineplot(data=df_daily, x="timestamp", y="value")
    plt.ylabel('Air quality')
    plt.xticks(rotation=30)
    fig = plot2.get_figure()
    fig.savefig('combined.png') 
    plt.cla()
    plt.clf()


if __name__ == "__main__":
    main()
    