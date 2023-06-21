using SkillBridge.Message;

namespace Server
{
    public interface IPostResponser
    {
        void PostProcess(NetMessageResponse message);
    }
}