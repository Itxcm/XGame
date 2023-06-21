using XClient;

public class CharacterManager : MonoSingleton<CharacterManager>
{
    private void Awake()
    {
        CreateRole.Instance.SelectRoleCall = SelectRoleCall;
    }

    private void SelectRoleCall(int idx)
    {
    }
}