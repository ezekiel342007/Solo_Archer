using Godot;

public partial class MoveState : NodeState
{
	[Export]
	private CharacterBody2D characterBody2D;

	[Export]
	private AnimatedSprite2D animatedSprite2D;

	public override void Enter()
	{
		animatedSprite2D.Play("move");
	}

	public override void Exit()
	{
		animatedSprite2D.Stop();
	}
}
