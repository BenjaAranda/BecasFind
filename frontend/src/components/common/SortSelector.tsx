interface SortSelectorProps {
  value: string;
  onChange: (v: string) => void;
}

export default function SortSelector({ value, onChange }: SortSelectorProps) {
  return (
    <select
      value={value}
      onChange={(e) => onChange(e.target.value)}
      className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
    >
      <option value="fechaAsc">Más próximas a vencer</option>
      <option value="fechaDesc">Mayor plazo</option>
      <option value="montoAsc">Menor monto</option>
      <option value="montoDesc">Mayor monto</option>
    </select>
  );
}
