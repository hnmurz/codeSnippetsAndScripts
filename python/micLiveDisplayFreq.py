import argparse
import scipy
import sys
import wave
import time
import numpy
from numpy.fft import fft
import pyaudio
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

LIVE_DISP_SIZE = 16000
class live_display():
    """
    Class to implement live display, this is taken from the example:
    https://matplotlib.org/examples/animation/bayes_update.html
    """
    def __init__(self, ax, xlim_start=0, xlim_end=1, ylim_start=0, ylim_end=1):
        self.ax = ax
        self.ax.set_xlim(xlim_start, xlim_end)
        self.ax.set_ylim(ylim_start, ylim_end)
        self.ax.grid(True)
        self.line, = ax.plot([], [])
        self.x = []
        self.y = []

    def update_xlabel(self, xlabel):
        self.ax.set_xlabel(xlabel)

    def update_data(self, x=[], y=[]):
        x = list(x)
        y = list(y)
        if x:
            self.x = x
        if y:
            self.y = y

    def set_data(self, x=[], y=[]):
        if not x:
            x = self.x
        if not y:
            y = self.y
        self.line.set_data(x, y)
        return self.line,

    def get_data(self):
        return self.x, self.y

    def init(self):
        self.line.set_data(self.x, self.y)
        return self.line,

class audio_analysis():
    """
    Analyze a audio source.
    """
    window_filter = []
    data = []
    data_window = []
    def __call__(self, apply_window=False):
        return self.read_and_transform(apply_window)

    def __normalize_and_cut(self, data):
        """
        Normalize the signal and cut the imaginary half due to the
        nature of the DFT algorithm.
        """
        return numpy.absolute(data[range(self.block_size // 2)] / self.block_size)

    def read_and_transform(self, apply_window=False):
        """
        Read signal data and do an FFT, the signal is normalized and
        cut. If a windowing function is provided then it is applied.
        """
        self.data = self.read_data()
        if apply_window == True:
            #print(len(data))
            #print(len(self.window_filter))
            self.data_window = self.data * self.window_filter
            data_s = fft(self.data_window)
        else:
            data_s = fft(self.data)
        return self.__normalize_and_cut(data_s)

    def get_time_data(self):
        return self.data, self.data_window

    def get_coeff_frequencies(self):
        """
        This will return the frequencies for the coefficients from
        the fft.
        """
        return numpy.arange(0,
                            self.signal_params['samp_rate'] / 2,
                            float(self.signal_params['samp_rate']) / self.block_size)

class wav_analysis(audio_analysis):
    """
    Analyze a .wav file
    """
    def __init__(self, file_in, block_size=256):
        self.file_in = file_in
        self.signal_in = wave.open(file_in, 'rb')
        params = self.signal_in.getparams()
        self.signal_params = {'samp_rate' : params[2],
                              'resolution' : params[1],
                              'n_chan' : params[0],
                              'n_frames' : params[3]}
        self.block_size = block_size # Number of frames to fetch from the file
        self.window_filter = numpy.hanning(self.block_size)

    def __del__(self):
        self.signal_in.close()

    def read_data(self):
        """
        Read block_size data from the input file.
        """
        data = self.signal_in.readframes(self.block_size)
        # Frames come in packed into 2 byte data structures
        return numpy.fromstring(data, 'Int16')

    def get_param(self, param):
        return self.signal_params[param]

    def print_file_info(self):
        """
        Print audio info about the input file.
        """
        print ("Info for file %s \n"
            "Sample rate: %d \n"
            "Resolution: %d \n"
            "Channel(s): %d \n"
            "Total frames: %d"
            % (self.file_in,
               self.signal_params['samp_rate'],
               self.signal_params['resolution'],
               self.signal_params['n_chan'],
               self.signal_params['n_frames']))

class mic_analysis(audio_analysis):
    """
    Analyze audio from mic input
    """
    def __init__(self, format=pyaudio.paInt16, channels=2, samp_rate=44100, block_size=256):
        self.pa = pyaudio.PyAudio()
        self.signal_in = self.pa.open(format=format,
                                      channels=channels,
                                      rate=samp_rate,
                                      input=True,
                                      frames_per_buffer=block_size)
        self.signal_params = {'samp_rate' : samp_rate,
                              'resolution' : pyaudio.paInt16,
                              'n_chan' : channels}
        self.block_size = block_size # Number of frames to fetch from the file
        self.window_filter = numpy.hanning(self.block_size)

    def __del__(self):
        self.signal_in.stop_stream()
        self.signal_in.close()
        self.pa.terminate()

    def read_data(self):
        """
        Read block_size data from the input file.
        """
        data = self.signal_in.read(self.block_size)
        # Frames come in packed into 2 byte data structures
        return numpy.fromstring(data, 'Int16')

    def get_param(self, param):
        return self.signal_params[param]

    def print_file_info(self):
        print ("Info for mic: %s\n"
               "Sample rate: %d \n"
               "Resolution: %d \n"
               "Channel(s): %d \n"
               "Total frames: %d"
               % (self.pa.get_default_output_device_info(),
                  self.signal_params['samp_rate'],
                  self.signal_params['resolution'],
                  self.signal_params['n_chan'],
                  self.block_size))

def factory_audio(input_str):
    if input_str == "mic":
        return mic_analysis()
    elif input_str.find(".wav"):
        return wav_analysis(input_str)
    else:
        print("Invalid input")
        return None

def animate_freq(i, live_disp, get_data_func, apply_window=False):
    live_disp.update_data(y=get_data_func(apply_window))
    return live_disp.set_data()

def animate_data(i, live_disp, get_data_func, apply_window=False):
    data, data_w = get_data_func()
    if apply_window == True:
        data = data
    if not numpy.any(data) or not numpy.any(data_w):
        data = [0]
    x, y = live_disp.get_data()
    data = y + list(data)
    live_disp.update_data(y=data[-LIVE_DISP_SIZE:])
    return live_disp.set_data()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Analyze audio from either mic or wav file')
    parser.add_argument('--plot_interval', type=int, default=10, help='Plotting interval in milliseconds')
    parser.add_argument('--input', type=str, default='test.wav', help='Either an input wav file or \"mic\" for mic input')
    parser.add_argument('--plot_signal', action='store_true', help='Plot the audio signal')
    parser.add_argument('--apply_window', action='store_true', help='Apply a window on the audio input.')
    args = parser.parse_args()
    print args

    audio = factory_audio(args.input)
    audio.print_file_info()

    x_min = -float(LIVE_DISP_SIZE) / audio.get_param("samp_rate")
    fig = plt.figure()

    # plotting the input signal seems to potentially generate lag
    if args.plot_signal:
        ax_data = fig.add_subplot(2, 1, 1)
        ld_data = live_display(ax_data,
                            xlim_start=x_min,
                            ylim_start=numpy.iinfo(numpy.int16).min,
                            ylim_end=numpy.iinfo(numpy.int16).max)
        ld_data.update_data(x=numpy.arange(start=x_min,
                                        stop=0,
                                        step= 1.0 / audio.get_param("samp_rate")),
                            y=numpy.zeros(LIVE_DISP_SIZE))

        anim_data = FuncAnimation(fig,
                                animate_data,
                                init_func=ld_data.init,
                                fargs=(ld_data,
                                        audio.get_time_data,
                                        args.apply_window),
                                interval=args.plot_interval,
                                blit=True)
        ax_freq = fig.add_subplot(2, 1, 2)
    else:
        ax_freq = fig.add_subplot(1, 1, 1)
        

    ld_freq = live_display(ax_freq,
                           xlim_end=audio.get_param("samp_rate")/2,
                           ylim_end=2000)
    ld_freq.update_data(x=audio.get_coeff_frequencies())
    anim_freq = FuncAnimation(fig,
                              animate_freq,
                              init_func=ld_freq.init,
                              fargs=(ld_freq,
                                     audio,
                                     args.apply_window),
                              interval=args.plot_interval,
                              blit=True)
    plt.show()
