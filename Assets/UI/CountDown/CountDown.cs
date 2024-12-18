using Godot;

public partial class CountDown : Control
{
	[Signal]
	public delegate void CountDownReachedEventHandler();

	private Timer countDownTimer;
	private ProgressBar countDownBar;

	public override void _Ready()
	{
		countDownTimer = GetNode<Timer>("Timer");
		countDownBar = GetNode<ProgressBar>("CountDownBar");
		countDownBar.Value = countDownTimer.TimeLeft;
	}

	public override void _PhysicsProcess(double delta)
	{
		countDownBar.Value = countDownTimer.TimeLeft;
		if (countDownBar.Value == 0.0)
		{
			EmitSignal(SignalName.CountDownReached);
			QueueFree();
		}
	}
}
