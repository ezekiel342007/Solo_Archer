using Godot;

public partial class DialogueScene2 : Control
{
	private Node participantsNode;
	private Control narrationBanner;

	public override void _Ready()
	{
		participantsNode = GetNode<Node>("ColorRect/Participants");
		narrationBanner = GetNode<Control>("ColorRect/NarrationBanner");
	}
}
