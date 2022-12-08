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
    df['timestamp'] = pd.to_datetime(df['timestamp']).dt.normalize()
    df = df.astype({'timestamp': 'datetime64[ns]'})

    df_daily = df[['value','timestamp','is_indoor']].resample('D', on='timestamp').mean()
    df_daily_indoor = df.query("is_indoor == 1")[['value','timestamp','is_indoor']].resample('D', on='timestamp').mean()
    df_daily_outdoor = df.query("is_indoor == 0")[['value','timestamp','is_indoor']].resample('D', on='timestamp').mean()
    df_daily_complex = pd.concat([df_daily_indoor, df_daily_outdoor], axis=0)
    df_daily_complex = df_daily_complex.reset_index()

    # create plot for inside/outside
    plot = sns.lineplot(data=df_daily_complex, x="timestamp", y="value",hue="is_indoor")
    ax = plt.gca()
    ax.xaxis.set_major_locator(ticker.MultipleLocator(base=1))
    plt.legend(title='Air quality', loc='upper left', labels=['outside', 'inside'])
    plt.ylabel('Air quality')
    fig = plot.get_figure()
    fig.savefig('analysedata/separate.png')  
    plt.cla()
    plt.clf()
    
    #  create plot for inside/outside combined
    plot2 = sns.lineplot(data=df_daily, x="timestamp", y="value")
    ax = plt.gca()
    ax.xaxis.set_major_locator(ticker.MultipleLocator(base=1))
    plt.ylabel('Air quality')
    #plt.show()
    fig = plot2.get_figure()
    fig.savefig('analysedata/combined.png')  
    plt.cla()
    plt.clf()


if __name__ == "__main__":
    main()
    