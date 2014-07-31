package fr.manashield.flex.thex.utils {
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class CellAlreadyOccupiedError extends Error
	{
		public function CellAlreadyOccupiedError(message:* = "", id:* = 0)
		{
			super(message, id);
		}
	}
}
