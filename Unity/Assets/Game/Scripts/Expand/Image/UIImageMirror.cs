using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;

public class UIImageMirror : BaseMeshEffect
{
    // ö�����ͣ���ʾ��������
    public enum Type
    {
        Double, // ˫����
        Quad, // �ľ���
    }

    [SerializeField]
    private Type m_type = Type.Double; // �������ͣ�Ĭ��ΪDouble

    [SerializeField]
    private bool m_UseGraphicAlpha = true; // �Ƿ�ʹ��ͼ�ε�͸����

    private Vector2 xy; // ͼƬ�Ĵ�С

    // ��ȡ�����þ�������
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

    // �ڱ༭���½��м����޸�
#if UNITY_EDITOR
    protected override void OnValidate()
    {
        xy = this.GetComponent<RectTransform>().sizeDelta; // ��ȡͼƬ��С
        base.OnValidate();
        if (graphic != null)
            graphic.SetVerticesDirty();
    }
#endif

    // ���������ʱ����
    protected override void OnEnable()
    {
        base.OnEnable();
        if (graphic != null)
            graphic.SetVerticesDirty();
        xy = this.GetComponent<RectTransform>().sizeDelta; // ��ȡͼƬ��С
    }

    // ��ȡ�������Ƿ�ʹ��ͼ�ε�͸����
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
    /// ʵ��˫����Ч��
    /// </summary>
    /// <param name="verts">�����б�</param>
    /// <param name="start">��ʼ����</param>
    /// <param name="end">��������</param>
    /// <param name="x1">���Ҿ���ƫ����</param>
    /// <param name="y1">���¾���ƫ����</param>
    /// <param name="x2">���Ҿ���ƫ����</param>
    /// <param name="y2">���¾���ƫ����</param>
    /// <param name="self">�Ƿ񽫵�ǰmeshҲ����һ�龵��</param>
    protected void ApplyGhostDouble(List<UIVertex> verts, int start, int end, float x1, float y1, float x2, float y2, bool self = false)
    {
        UIVertex vt;

        var neededCpacity = verts.Count * 2;
        if (verts.Capacity < neededCpacity)
            verts.Capacity = neededCpacity;

        // ���������б����о���任
        for (int i = start; i < end; i++)
        {
            vt = verts[i];
            if (!self)
                verts.Add(vt); // ���һ��mesh

            Vector3 v = vt.position;
            int offset = i % 6;
            switch (offset)
            {
                case 0:
                case 1:
                case 5: v.x += x1; break; // ���Ҿ���
                case 3:
                case 4:
                case 2: v.x += x2; break; // ���Ҿ���
            }
            switch (offset)
            {
                case 1:
                case 2:
                case 3: v.y += y1; break; // ���¾���
                case 0:
                case 4:
                case 5: v.y += y2; break; // ���¾���
            }

            vt.position = v;
            verts[i] = vt;
        }
    }

    /// <summary>
    /// ʵ���ľ���Ч��
    /// </summary>
    /// <param name="verts">�����б�</param>
    /// <param name="start">��ʼ����</param>
    /// <param name="end">��������</param>
    protected void ApplyGhost(List<UIVertex> verts, int start, int end)
    {
        if (m_type == Type.Double) // �����������Ϊ˫����
        {
            var neededCpacity = verts.Count * 2;
            if (verts.Capacity < neededCpacity)
                verts.Capacity = neededCpacity;
            ApplyGhostDouble(verts, start, end, 0, 0, -xy.x / 2, 0); // ���Ҿ���
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, xy.x, 0, -xy.x / 2, 0, true); // ���Ҿ���
        }
        else // �����������Ϊ�ľ���
        {
            var neededCpacity = verts.Count * 4;
            if (verts.Capacity < neededCpacity)
                verts.Capacity = neededCpacity;
            start = 0;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, 0, 0, -xy.x / 2, xy.y / 2); // ���Ͼ���
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, xy.x, 0, -xy.x / 2, xy.y / 2); // ���Ͼ���
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, 0, -xy.y, -xy.x / 2, xy.y / 2); // ���¾���
            start = end;
            end = verts.Count;
            ApplyGhostDouble(verts, start, end, xy.x, -xy.y, -xy.x / 2, xy.y / 2, true); // ���¾���
        }
    }

    // ��дBaseMeshEffect�е�ModifyMesh������ʵ�־���Ч��
    public override void ModifyMesh(VertexHelper vh)
    {
        if (!IsActive()) // ������δ���ã�ֱ�ӷ���
            return;
        xy = GetComponent<RectTransform>().sizeDelta; // ��ȡͼƬ��С

        List<UIVertex> output = new List<UIVertex>();
        vh.GetUIVertexStream(output);
        ApplyGhost(output, 0, output.Count); // ʵ�־���Ч��
        vh.Clear();
        vh.AddUIVertexTriangleStream(output);
    }
}