using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;

public class UIImageMirror : BaseMeshEffect
{
    // 枚举类型，表示镜像类型
    public enum Type
    {
        Double, // 双镜像
        Quad, // 四镜像
    }

    [SerializeField]
    private Type m_type = Type.Double; // 镜像类型，默认为Double

    [SerializeField]
    private bool m_UseGraphicAlpha = true; // 是否使用图形的透明度

    private Vector2 xy; // 图片的大小

    // 获取和设置镜像类型
    public Type GhostType
    {
        get { return m_type; }
        set
        {
            if (m_type == value)
                return;
            m_type = value;

            if (graphic != null)
                graphic.SetVerticesDirty();
        }
    }

    // 在编辑器下进行检查和修改
#if UNITY_EDITOR
    protected override void OnValidate()
    {
        xy = this.GetComponent<RectTransform>().sizeDelta; // 获取图片大小
        base.OnValidate();
        if (graphic != null)
            graphic.SetVerticesDirty();
    }
#endif

    // 当组件启用时调用
    protected override void OnEnable()
    {
        base.OnEnable();
        if (graphic != null)
            graphic.SetVerticesDirty();
        xy = this.GetComponent<RectTransform>().sizeDelta; // 获取图片大小
    }

    // 获取和设置是否使用图形的透明度
    public bool useGraphicAlpha
    {
        get { return m_UseGraphicAlpha; }
        set
        {
            m_UseGraphicAlpha = value;
            if (graphic != null)
                graphic.SetVerticesDirty();
        }
    }

    /// <summary>
    /// 实现双镜像效果
    /// </summary>
    /// <param name="verts">顶点列表</param>
    /// <param name="start">起始索引</param>
    /// <param name="end">结束索引</param>
    /// <param name="x1">左右镜像偏移量</param>
    /// <param name="y1">上下镜像偏移量</param>
    /// <param name="x2">左右镜像偏移量</param>
    /// <param name="y2">上下镜像偏移量</param>
    /// <param name="self">是否将当前mesh也进行一遍镜像</param>
    protected void ApplyGhostDouble(List<UIVertex> verts, int start, int end, float x1, float y1, float x2, float y2, bool self = false)
    {
        UIVertex vt;

        var neededCpacity = verts.Count * 2;
        if (verts.Capacity < neededCpacity)
            verts.Capacity = neededCpacity;

        // 遍历顶点列表，进行镜像变换
        for (int i = start; i < end; i++)
        {
            vt = verts[i];
            if (!self)
                verts.Add(vt); // 添加一遍mesh

            Vector3 v = vt.position;
            int offset = i % 6;
            switch (offset)
            {
                case 0:
                case 1:
                case 5: v.x += x1; break; // 左右镜像
                case 3:
                case 4:
                case 2: v.x += x2; break; // 左右镜像
            }
            switch (offset)
            {
                case 1:
                case 2:
                case 3: v.y += y1; break; // 上下镜像
                case 0:
                case 4:
                case 5: v.y += y2; break; // 上下镜像
            }

            vt.position = v;
            verts[i] = vt;
        }
    }

    /// <summary>
    /// 实现四镜像效果
    /// </summary>
    /// <param name="verts">顶点列表</param>
    /// <param name="start">起始索引</param>
    /// <param name="end">结束索引</param>
    protected void ApplyGhost(List<UIVertex> verts, int start, int end)
    {
        if (m_type == Type.Double) // 如果镜像类型为双镜像
        {
            var neededCpacity = verts.Count * 2;
            if (verts.Capacity < neededCpacity)
                verts.Capacity = neededCpacity;
            ApplyGhostDouble(verts, start, end, 0, 0, -xy.x / 2, 0); // 左右镜像
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, xy.x, 0, -xy.x / 2, 0, true); // 左右镜像
        }
        else // 如果镜像类型为四镜像
        {
            var neededCpacity = verts.Count * 4;
            if (verts.Capacity < neededCpacity)
                verts.Capacity = neededCpacity;
            start = 0;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, 0, 0, -xy.x / 2, xy.y / 2); // 左上镜像
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, xy.x, 0, -xy.x / 2, xy.y / 2); // 右上镜像
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, 0, -xy.y, -xy.x / 2, xy.y / 2); // 左下镜像
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, xy.x, -xy.y, -xy.x / 2, xy.y / 2, true); // 右下镜像
        }
    }

    // 重写BaseMeshEffect中的ModifyMesh方法，实现镜像效果
    public override void ModifyMesh(VertexHelper vh)
    {
        if (!IsActive()) // 如果组件未启用，直接返回
            return;
        xy = GetComponent<RectTransform>().sizeDelta; // 获取图片大小

        List<UIVertex> output = new List<UIVertex>();
        vh.GetUIVertexStream(output);
        ApplyGhost(output, 0, output.Count); // 实现镜像效果
        vh.Clear();
        vh.AddUIVertexTriangleStream(output);
    }
}