namespace XShare
{
    public class Singleton<T> where T : new()
    {
        private static readonly object lockObj = new object();

        private static T instance;

        public static T Instance
        {
            get
            {
                while (instance == null)
                {
                    lock (lockObj)
                    {
                        if (instance == null)
                        {
                            instance = new T();
                        }
                    }
                }

                return instance;
            }
        }
    }
}
