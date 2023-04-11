namespace sub_synth
{
  class pulse
  {
    public:
      pulse(double sample_rate, double frequency);

      virtual double get_sample(double sample) = 0;

      inline double tick()
      {
        get_sample(state++);
        state = state % (sample_rate / frequency);
      }

      inline void reset()
      {
        state = 0;
      }

      void set_sample_rate(double new_rate);

      void set_frequency(double new_frequency);

      virtual ~pulse();

    protected:
      double sample_rate;
      double frequency;

    private:
      double state = 0;
  };
} // end namespace sub_synth
